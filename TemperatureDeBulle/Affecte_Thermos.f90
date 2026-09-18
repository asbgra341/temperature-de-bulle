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
!   Ficiher : Subroutine Affectation des données thermodynamiques
! ----------------------------------------------------------------------------

subroutine AffecteThermos
    Use Dimensions
    Use Thermos
    implicit none
    integer :: i
    integer :: j

    allocate(ANT(NC,5))

    ! Lecture des donneesThermo
    open(unit=11,file=TRIM("DonneesCoefAntoine.txt"),status="old")
        do i=1,NC
            read(11,*)(ANT(i,j),j=1,5)
        end do
    close (11)


end subroutine
