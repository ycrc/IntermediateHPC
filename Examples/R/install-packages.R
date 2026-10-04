# installs any of the packages named on the command line that are missing,
# into your personal R library (R_LIBS_USER)
# the MPI job scripts run this once before srun, so the MPI tasks don't all
# try to install at the same time
#   Rscript install-packages.R Rmpi

pkgs = commandArgs(trailingOnly=TRUE)
installed <- function(p) suppressWarnings(requireNamespace(p, quietly=TRUE))
missing = pkgs[!sapply(pkgs, installed)]

if (length(missing) > 0) {
 lib = Sys.getenv("R_LIBS_USER")
 dir.create(lib, recursive=TRUE, showWarnings=FALSE)
 .libPaths(c(lib, .libPaths()))
 cat("installing", missing, "into", lib, "\n")
 # Rmpi is compiled against the Open MPI that the R module loads
 install.packages(missing, lib=lib, repos="https://cloud.r-project.org",
                  configure.args=c(Rmpi="--with-Rmpi-type=OPENMPI"))
 still_missing = missing[!sapply(missing, installed)]
 if (length(still_missing) > 0) stop("could not install ", paste(still_missing, collapse=" "))
}
