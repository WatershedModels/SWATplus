      subroutine pl_grow
      
      use plant_data_module
      use basin_module
      use hru_module, only : hru, uapd, uno3d, lai_yrmx, par, bioday, ep_day, es_day,              &
         ihru, ipl, pet_day, rto_no3, rto_solp, sum_no3, sum_solp, uapd_tot, uno3d_tot, vpd
      use plant_module
      use carbon_module
      use organic_mineral_mass_module
      use time_module
      
      implicit none 
      
      integer :: j              !none               |HRU number
      integer :: idp            !none               |plant number from plants.plt
      real :: resnew_n          !                   |
      real :: resnew            !                   |  

      j = ihru

      do ipl = 1, pcom(j)%npl
        !! check for start and end of dormancy of temp-based growth plant
        idp = pcom(j)%plcur(ipl)%idplt
        if (pldb(idp)%trig == "temp_gro") then
          call pl_dormant
        end if
       
        !! plant will not undergo stress if dormant
        if (pcom(j)%plcur(ipl)%idorm == "n" .and. pcom(j)%plcur(ipl)%gro == "y") then

          call pl_biomass_gro
        
          call pl_root_gro

          call pl_leaf_gro
          call pl_leaf_senes         
             
          !! leaf drop for moisture based growth plants - any time of year
          if (pldb(idp)%trig == "moisture_gro") then
            resnew = pcom(j)%plcur(ipl)%leaf_tov * pcom(j)%leaf(ipl)%mass
            resnew_n = pcom(j)%plcur(ipl)%leaf_tov * pcom(j)%leaf(ipl)%nmass
            call pl_leaf_drop (resnew, resnew_n)
          end if
   
          call pl_seed_gro
          
          if (time%end_yr == 1) call pl_mortality

          call pl_partition

        end if
      end do    ! loop for number of plants
      
      return
      end subroutine pl_grow