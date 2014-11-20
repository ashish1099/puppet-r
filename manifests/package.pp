define addon_package (
        $repo = 'http://cran.rstudio.com',
        $dependencies = "TRUE",
        $ensure = 'present' ) {

        Exec { require => Class['r'] }
        exec { "updating_r_packages_$name" : command => "R -q -e \"update.packages(repos='$repo', checkBuilt=TRUE, ask=FALSE)\"", refreshonly => true }

        case $ensure {
                present : { exec { "install_r_package_$name" :
                        command => "R -q -e \"install.packages('$name', repos='$repo', dependencies = $dependencies)\"",
                        unless => "R -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
                        notify => Exec["updating_r_packages_$name"] } }
                absent : { exec { "uninstalling_r_package_$name" :
                        command => "R -q -e \"remove.packages('$name')\"",
                        unless  => "R -q -e '\"$name\" %in% installed.packages()' | grep 'FALSE'",
                        notify => Exec["updating_r_packages_$name"] } }
                default : { err ( "Something has failed, Please check" ) }
        }
}
