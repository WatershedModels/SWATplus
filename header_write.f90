     subroutine header_write
    
     use basin_module
     use reservoir_module
    
!!   open soils.out file       
      if (pco%solout > 0) then
        open (121,file="soils.out")
        write (121,1002)
        if (pco%csvout == 1 .and. pco%solout > 0) then
          open (123,file="soils.csv")
          write (123,1002)
        end if
        write (9000,*) 'SOILS     soils.out'
      end if
      
!!   open mgt.out file 
      if (pco%mgtout > 0) then
        open (143,file="mgt.out",recl=800)
        write (143,*) mgt_hdr
        write (143,*) mgt_hdr_unt1
        write (143,*) mgt_hdr_unt2
        write (9000,*) 'MGT     mgt.out'
      end if
      
!!  yield biomass file
      if (pco%mgtout > 0) then
        open (4700,file="yield.out", recl=800)
        if (pco%csvout == 1 .and. pco%mgtout > 0) then
          open (4701,file="yield.csv", recl=800)
        end if
      end if  
      
      if (pco%hydcon > 0) then
        open (7000,file="hydcon.out")
          if (pco%csvout == 1 .and. pco%hydcon > 0) then
            open (7001,file="hydcon.csv") 
          end if
        write (9000,*) 'HYDCON     hydcon.out'
 !       write (7000, 1004)
      end if
      
      if (pco%hyd >= 0) then
        open (5001,file="hyd-out.out",recl=800)
        write (5001,*) hyd_hdr
        if (pco%csvout == 1 .and. pco%hyd >= 0) then
          open (5007,file="hyd-out.csv",recl=800)
          write (5007,'(*(G0.3,:","))') hyd_hdr
        end if 
        write (9000,*) 'HYDOUT     hyd-out.out'
        
        open (5004,file="hyd-in.out",recl=800)
        write (5004,*) hyd_hdr
          if (pco%csvout == 1 .and. pco%hyd >= 0) then
            open (5008,file="hyd-in.csv",recl=800)
            write (5008,'(*(G0.3,:","))') hyd_hdr
          end if 
        write (9000,*) 'HYDIN     hyd-in.out'
        
        open (5005,file="deposition.out",recl=800)
        write (5005,*) hyd_hdr
          if (pco%csvout == 1) then
            open (5009,file="deposition.csv",recl=800)
            write (5009,'(*(G0.3,:","))') hyd_hdr
          end if
        write (9000,*) 'DEPO     deposition.out'
      end if
      
      if (pco%res >= 0) then
        open (5002,file="reservoir.out",recl=800)
        allocate (res_hdr(1))
        allocate (res_hdr_unt(1))
        write (5002,*) (res_hdr(1))
        write (5002,*) (res_hdr_unt(1))
          if (pco%csvout == 1 .and. pco%res > 0) then
            open (5006,file="reservoir.csv",recl=800)
            write (5006,'(*(G0.3,:","))') res_hdr
            write (5006,'(*(G0.3,:","))') res_hdr_unt
          end if
      end if
 1002 format (t15,'SURFACE',t29,'-------  SOIL PROFILE  -------',/,   &
        t8,'DAY',t15,'SOL_RSD',t27,'SOL_P',t38,                       &
        'NO3',t47,'ORG_N',t57,'ORG_P',t70,'CN'/,t16,                  &                   
        '(t/ha)',t25,'(kg/ha)',t35,                                   &                                   
        '(kg/ha)',t45,'(kg/ha)',t56,'(kg/ha)')
      return
      end subroutine header_write  