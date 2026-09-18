!   PROGRAMMATION FORTRAN - ENSGTI 1A
!   Réalisé par :                               Encadrant :
!   Aboubacar Sidiki BANGOURA                   Sylvain SERRA
!   Bienvenu Désiré DAMIBA                      Pierre CEZAC
!
!   Année Universitaire: 2020-2021
! ----------------------------------------------------------------------------
!   But: Calcul de la temperature de bulle pour un melange ideal
!                constitue de NC constituants liquides
! ----------------------------------------------------------------------------
!   Ficiher : Module messages
! ----------------------------------------------------------------------------

module Messages

contains

subroutine messagedacceuil()

        implicit none
        print*,'**************************************************************************************************************'
        print*,'**************************************************************************************************************'
        print*,'                                               DEBUT DU PROGRAMME'
        print*,'**************************************************************************************************************'
        print*,''
        print*,"                                Modelisation de la Temperature de Bulle"
        print*,""
        print*,''
        print*,"Bienvenue dans votre programme de modelisation de la temperature de bulle pour un melange ideal ou non"
        print*,"constitue de NC constituants liquides."
        print*,''
        print*,''

    endsubroutine messagedacceuil

    subroutine messagedefin()

        implicit none
        print*,''
        print*,'**************************************************************************************************************'
        print*,'                                                   FIN DU PROGRAMME'
        print*,'**************************************************************************************************************'
        print*,'**************************************************************************************************************'
        print*,''

    endsubroutine messagedefin

    subroutine MessageErreur(err)

        implicit none
        integer :: err

        if(err /= 0) THEN
            print*
            print*," PROGRAM ERROR : Le nombre saisi est incoherent "
            print*
            print*,' '
            call messagedefin()
            stop
        endif
    endsubroutine


endmodule
