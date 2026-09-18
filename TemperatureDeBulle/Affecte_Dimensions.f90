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
!   Ficiher : Subroutine Affectation des dimensions
! ----------------------------------------------------------------------------

subroutine AffecteDimensions
    Use Dimensions
    implicit none

    open(unit=10,file=TRIM("DonneesDimensions.txt"),status="old")
        read(10,*)NC
    close (10)
end subroutine
