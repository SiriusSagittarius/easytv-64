include ../../Makefile.include GNUTLS-VERSION ../../download-files.include
DEPS = ../../Makefile.include Makefile ../../download-files.include \
                              add-dl-as-private-lib.patch \
                              03-support-correct-cisdigit.patch \
                              android-fpending.patch \
                              003-android-timezone_t.patch

# disable rpl_malloc and rpl_realloc symbols in glib
# causes linking errors in libmicrohttpd and ffmpeg with missing symbols
# Undefined symbols for architecture arm64:
#  "_rpl_realloc", referenced from:
#      _gnutls_realloc in libgnutls.a(mem.o)
#      _gnutls_realloc_zero in libgnutls.a(init.o)
#      __asn1_realloc in libgnutls.a(parser_aux.o)
#      __asn1_ordering_set_of in libgnutls.a(coding.o)
#      __asn1_realloc in libgnutls.a(decoding.o)
#      __gnutls_fread_file in libgnutls.a(read-file.o)
#      _rpl_getdelim in libgnutls.a(getdelim.o)
#      ...
CONFIGURE_OPTIONS+= ac_cv_func_malloc_0_nonnull=yes \
                    ac_cv_func_realloc_0_nonnull=yes

# The Android NDK's bionic libc declares the *type* timezone_t unconditionally,
# but only declares/implements tzalloc/localtime_rz/mktime_z/tzfree starting at
# API level 35 (__INTRODUCED_IN(35)). Our minSdk is 21, so gnulib's AC_CHECK_TYPES
# probe for timezone_t wrongly concludes the whole time_rz API is present, skips
# building its own gnulib replacement (src/gl/time_rz.c), and nstrftime.c /
# parse-datetime.y end up calling undeclared functions. Forcing this cache
# variable to "no" makes gnulib provide its own self-contained implementation,
# which works on all API levels.
CONFIGURE_OPTIONS+= ac_cv_type_timezone_t=no

# configuration settings
CONFIGURE=./configure --prefix=$(PREFIX) \
                      --disable-shared \
                      --without-p11-kit \
                      --disable-nls \
                      --with-included-unistring \
                      --with-included-libtasn1 \
                      --enable-local-libopts \
                      --disable-doc \
                      --disable-tests \
                      --disable-guile \
                      --disable-tools \
                      --without-idn \
                      $(CONFIGURE_OPTIONS)

# LLVM 15 has raised this to error by default. drop back to warning
CFLAGS+= -Wno-error=implicit-int
export CFLAGS

LIBDYLIB=$(PLATFORM)/lib/.libs/lib$(LIBNAME).a

all: .installed-$(PLATFORM)

$(PLATFORM): $(DEPS) | $(TARBALLS_LOCATION)/$(ARCHIVE).$(HASH_TYPE)
	rm -rf $(PLATFORM)/*; mkdir -p $(PLATFORM)
	cd $(PLATFORM); $(ARCHIVE_TOOL) $(ARCHIVE_TOOL_FLAGS) $(TARBALLS_LOCATION)/$(ARCHIVE)
	cd $(PLATFORM); patch -p1 -i ../add-dl-as-private-lib.patch
	cd $(PLATFORM); patch -p1 -i ../03-support-correct-cisdigit.patch
	cd $(PLATFORM); patch -p1 -i ../android-fpending.patch
ifeq ($(OS),android)
	# Bionic declares the timezone_t type unconditionally, but only declares/
	# implements tzalloc/localtime_rz/mktime_z/tzfree from API 35 on. Our minSdk
	# is lower, so gnulib is forced (via ac_cv_type_timezone_t=no below) to provide
	# its own implementation - this patch stops it from also redeclaring the
	# already-existing timezone_t type, which would conflict with bionic's.
	cd $(PLATFORM); patch -p1 -i ../003-android-timezone_t.patch
endif
	cd $(PLATFORM); $(AUTORECONF) -vif
	cd $(PLATFORM); $(CONFIGURE)

$(LIBDYLIB): $(PLATFORM)
	$(MAKE) -C $(PLATFORM)

.installed-$(PLATFORM): $(LIBDYLIB)
	$(MAKE) -C $(PLATFORM) install
	touch $@

clean:
	$(MAKE) -C $(PLATFORM) clean
	rm -f .installed-$(PLATFORM)

distclean::
	rm -rf $(PLATFORM) .installed-$(PLATFORM)
