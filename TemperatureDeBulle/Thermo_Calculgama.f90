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
!   Ficiher : Subroutine calcul de gama
! ----------------------------------------------------------------------------

subroutine CalculGama(gama)
    Use Dimensions
    Use Thermos
    Use Messages

    implicit none

    integer :: MODE
    doubleprecision , dimension(NC),intent(out) :: gama
    common MODE

    if (MODE.eq.1) then
        gama=1
    elseif (MODE.eq.2) then
        print*,"Le mode 2 : gamma = NRTL(x, T, Aij, Cij) "
        print*,"Le modele de la solution non ideale n'est pas implemente dans ce programme !!!!"
        print*,"Pour aller plus loin sur le mode 2 : https://github.com/yajeddig "
        print*
        call messagedefin()
        stop

    endif

endsubroutine

