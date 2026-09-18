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
!   Ficiher : Module opératoires
! ----------------------------------------------------------------------------

module Operatoires
    implicit none

    double precision, allocatable,dimension(:):: Zi !  Composition du mélange
    doubleprecision :: P            ! Pression extérieure
    doubleprecision :: Tmin         ! Valeur min de la temperature de bulle
    doubleprecision :: Tmax         ! Valeur max de la temperature de bulle

end module
