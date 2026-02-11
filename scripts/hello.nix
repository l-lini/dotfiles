{ stdenv, fetchzip }:

stdenv.mkDerivation {
  pname = "hello";
  version = "2.12.2";
  src = fetchzip {
    url = "https://ftp.gnu.org/gnu/hello/hello-2.12.2.tar.gz";
    sha256 = "Dn2iD849c+DYSTjUS6bzuvkwqFz2oDdwhGkfHoeXlbY=";
  };
}
