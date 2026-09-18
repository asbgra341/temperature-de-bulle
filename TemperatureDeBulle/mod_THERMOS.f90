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
!   Ficiher : Module des données thermodynamiques
! ----------------------------------------------------------------------------

module Thermos
    implicit none
    doubleprecision, allocatable, dimension(:,:):: ANT

    doubleprecision, parameter :: R = 8.3145D0
    doubleprecision, parameter :: Preci= 1E-9        ! Epsillon pour le calcul de Tbulle



end module
