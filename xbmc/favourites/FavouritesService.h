/*
 *  Copyright (C) 2005-2018 Team Kodi
 *  This file is part of Kodi - https://kodi.tv
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSES/README.md for more information.
 */

#pragma once

#include "FileItem.h"
#include "threads/CriticalSection.h"
#include "utils/EventStream.h"

#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

class CFavouritesService
{
public:
  explicit CFavouritesService(std::string userDataFolder);
  virtual ~CFavouritesService() = default;

  /** For profiles*/
  void ReInit(std::string userDataFolder);

  bool IsFavourited(const CFileItem& item, int contextWindow) const;
  std::shared_ptr<CFileItem> GetFavourite(const CFileItem& item, int contextWindow) const;
  std::shared_ptr<CFileItem> ResolveFavourite(const CFileItem& favItem) const;

  /*! \brief Find the favourite whose assigned voice command matches the given text.
   *  \param voiceCommand The spoken/typed text to match. Comparison is case-insensitive
   *         and ignores leading/trailing whitespace on both sides.
   *  \return The matching favourite, or nullptr if none of the favourites have a
   *          matching voice command assigned (see FAVOURITES_UTILS::ChooseAndSetVoiceCommand).
   */
  std::shared_ptr<CFileItem> FindByVoiceCommand(const std::string& voiceCommand) const;

  int Size() const;
  void GetAll(CFileItemList& items) const;
  bool AddOrRemove(const CFileItem& item, int contextWindow);
  bool Save(const CFileItemList& items);

  /*! \brief Refresh favourites for directory providers, e.g. the GUI needs to be updated
   */
  void RefreshFavourites();

  struct FavouritesUpdated { };

  CEventStream<FavouritesUpdated>& Events() { return m_events; }

private:
  CFavouritesService() = delete;
  CFavouritesService(const CFavouritesService&) = delete;
  CFavouritesService& operator=(const CFavouritesService&) = delete;
  CFavouritesService(CFavouritesService&&) = delete;
  CFavouritesService& operator=(CFavouritesService&&) = delete;

  void OnUpdated();
  bool Persist();

  std::string m_userDataFolder;
  CFileItemList m_favourites;
  mutable std::unordered_map<std::string, std::shared_ptr<CFileItem>> m_targets;
  CEventSource<FavouritesUpdated> m_events;
  mutable CCriticalSection m_criticalSection;
};
