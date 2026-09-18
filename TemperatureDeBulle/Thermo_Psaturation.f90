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
!   Ficiher : Subroutine calcul de la pression de vapeur saturante
! ----------------------------------------------------------------------------

subroutine Psaturation(Temp,Psat)
    Use Dimensions
    Use Thermos

    implicit none
    integer :: i
    doubleprecision, intent(in) :: Temp
    double precision, dimension(NC), intent(out):: Psat

    do i=1,NC
        Psat(i)=exp(ANT(i,1)+(ANT(i,2)/Temp)+ANT(i,3)*log(Temp)+ANT(i,4)*Temp**ANT(i,5))
    enddo

end subroutine
