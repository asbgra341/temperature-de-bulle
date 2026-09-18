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
!   Ficiher : Subroutine Affectation des données opératoires
! ----------------------------------------------------------------------------

subroutine AffecteOperatoires
    Use Dimensions
    Use Thermos
    Use Operatoires

    implicit none

    integer ::i

    allocate(Zi(NC))

    P=0
    Tmin=0
    Tmax=0
    Zi=0

    open(11, file="DonneesOperatoires.txt", status="old")
        read(11,*)P
        read(11,*)Tmin
        read(11,*)Tmax
        do i=1,NC
            read(11,*)Zi(i)
        end do
    close(11)

end subroutine
