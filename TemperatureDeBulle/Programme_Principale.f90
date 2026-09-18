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
!   Ficiher : Subroutine Programme principale
! ----------------------------------------------------------------------------

program TemperatureDeBulle

    Use Dimensions
    Use Thermos
    Use Operatoires
    Use Messages

    implicit none
    integer :: MODE, err
    doubleprecision ,allocatable, dimension(:) :: gama
    doubleprecision :: Tebullition, Temp
    common MODE

    call messagedacceuil

    print*,"Choix du comportement decrit par le modele Thermodynamique NRTL "
    print*
     33 print*,"tapez 1 pour une solution ideale et tapez 2 pour une solution non ideale"
    print*
    read(*,*,iostat=err)MODE
    call MessageErreur(err)

    if ((MODE/=1).AND.(MODE/=2)) then
        goto 33
    endif
    print*


    call AffecteDimensions
    call AffecteOperatoires
    call AffecteThermos

    allocate (gama(NC))
    Temp = 0
    gama = 0

    call CalculGama(gama)
    call CalculTbulle(gama, Zi,Tebullition)
    print*,"Temperature d'ebullition du melange est (K): "
    print*
    print*,Tebullition
    print*
    call messagedefin




end program


