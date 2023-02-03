#!/bin/bash

#if [[ $string =~ '-f meteo_filtered_data_v1.csv' ]]; then 

######################################################################################################################################
#--------------------------------------------------------------VARIABLES-------------------------------------------------------------#
######################################################################################################################################


LOCATION=0
DATE=0
TRI=0


######################################################################################################################################
#-------------------------------------------------------------ERROR REPORT-----------------------------------------------------------#
######################################################################################################################################


#-----------------------chek if all options are correct and returns an error if an option is not present-----------------------------#

for string in "$@"; do

	if [[ $string != "-h" && $string != "-m" && $string != "-w" && $string != "-t1" && $string != "-t2" && $string != "-t3" && $string != "-p1" && $string != "-p2" && $string != "-p3" && $string != "-F" && $string != "-G" && $string != "-S" && $string != "-A" && $string != "-O" && $string != "-Q" && $string != "--tab" && $string != "--abr" && $string != "--avl" && $string != ????-??-?? && $string != '--help' ]]; then 
		echo 'ERROR OPTION DOES NOT EXIST'
		exit
	fi
done


######################################################################################################################################
#-----------------------------------------------------------------help---------------------------------------------------------------#
######################################################################################################################################


for string in "$@"; do

	if [[ $string = '--help' ]]; then  
		echo "date option : simply enter the min and max date spaced with a space (example 2010-05-13 2015-03-26)"
		echo "t/p<mode> : enter the mode just after the option (example -t1 -p2)
			temperature -t or pressure -p option"
		echo "--tab/abr/avl : choose your sorting mode only one option accepted"
		echo "-F/G/Q... : choose your location option only one option accepted"
		echo "-w wind option"
		echo "-m moisture option"
		echo "-h height option"
		exit
	fi
done


######################################################################################################################################
#------------------------------------------------------------VERIFICATION------------------------------------------------------------#
######################################################################################################################################


#----------------------------------------------------chek if a date option is requested----------------------------------------------#

for string in "$@"; do

	if [[ $string = ????-??-?? ]]; then  
		DATE=$(( $DATE + 1 ))
		if [[ $DATE = '1' ]]; then
			min=$string
		else
			max=$string
		fi
	fi
done

#-------------------------------------------------chek if a location option is requested---------------------------------------------#

for string in "$@"; do

	if [[  $string =~ "-F" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	elif [[  $string =~ "-G" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	elif [[  $string =~ "-S" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	elif [[  $string =~ "-A" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	elif [[  $string =~ "-O" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	elif [[  $string =~ "-Q" ]]; then
		LOCATION=$(( $LOCATION + 1 ))
	fi

done

#----------------------------------------------------chek if a tri option is requested-----------------------------------------------#

for string in "@"; do

	if [[  $string =~ "--tab" ]]; then
		TRI=$(( $TRO + 1 ))
		ARBRE='tab'		
	elif [[  $string =~ "--abr" ]]; then
		TRI=$(( $TRI + 1 ))
		ARBRE='abr'
	elif [[  $string =~ "--avl" ]]; then
		TRI=$(( $TRI + 1 ))
	fi		
done


######################################################################################################################################
#-------------------------------------------------------------ERROR REPORT-----------------------------------------------------------#
######################################################################################################################################


#-------error detected if the user enters more or less than 2 dates or if the max date is before the min date in the options---------#

if [[ $DATE != '2' && $DATE != '0' ]]; then 
	echo 'ERROR, NEED TWO DATES TO MAKE AN INTERVAL'
	exit

fi

if [[ $DATE == '2' ]]; then

	if [[ $min > $max ]]; then 
		echo 'ERROR, THE FIRST OPTION DATE MUST BE LESS THAN THE SECOND'
		exit
		

######################################################################################################################################
#--------------------------------------------------------------DATE FILTER-----------------------------------------------------------#
######################################################################################################################################
	
	
#--------------------create a new file based on the min and max date that will be reused to filter with the--------------------------#

	else 
		sed -n '1!p' meteo_filtered_data_v1.csv | sort -t ";" -k 2 | grep -n "$min" | cut -d ':' -f 1 > filtered_by_date.txt 
		lmin=$(head -1 filtered_by_date.txt)

		sed -n '1!p' meteo_filtered_data_v1.csv | sort -t ";" -k 2 | grep -n "$max" | cut -d ':' -f 1 > max.txt 
		lmax=$(tail -1 max.txt)

		sed -n '1!p' meteo_filtered_data_v1.csv | sort -t ";" -k 2 | sed -n "$lmin,$lmax"'p' > filtered_by_date.txt 
		rm max.txt 

	fi
		
fi


######################################################################################################################################
#------------------------------------------------------------------TAB---------------------------------------------------------------#
######################################################################################################################################


if [[ $ARBRE == 'tab' ]]; then


	######################################################################################################################################
	#-----------------------------------------------------NO LOCATIONS AND NO DATE-------------------------------------------------------#
	######################################################################################################################################


	if [[ $LOCATION == '0' && $DATE != '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 > windspeed.txt
				#f- open TAB f- open tab_croissant.c

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-------------------------------------------------------DATE WITHOUT LOCATIONS-------------------------------------------------------#
	######################################################################################################################################


	elif [[ $LOCATION == '0' && $DATE == '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,5 > windspeed.txt

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-----------------------------------------------------------ERROR REPORT-------------------------------------------------------------#
	######################################################################################################################################

		
	#------------------------------------------chek if the number of location options is correct-----------------------------------------#

	elif [[ $LOCATION != '1' ]]; then 
		echo 'ERROR ONLY ONE POSSIBLE LOCATION'
		exit
		
	fi


	######################################################################################################################################
	#-----------------------------------------------------LOCATION WITHOUT DATTE---------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#

	if [[ $LOCATION == '1' && $DATE != '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' meteo_filtered_data_v1.csv > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.tx


					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt
						
					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
						
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' meteo_filtered_data_v1.csv > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' meteo_filtered_data_v1.csv > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' meteo_filtered_data_v1.csv > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' meteo_filtered_data_v1.csv > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt
						
					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' meteo_filtered_data_v1.csv > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt
						
					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		

	######################################################################################################################################
	#-------------------------------------------------------LOCATION WITH DATTE----------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#
		
	elif [[ $LOCATION == '1' && $DATE == '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' filtered_by_date.txt > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
						
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' filtered_by_date.txt > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' filtered_by_date.txt > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' filtered_by_date.txt > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' filtered_by_date.txt > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' filtered_by_date.txt > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		
	fi


######################################################################################################################################
#------------------------------------------------------------------ABR---------------------------------------------------------------#
######################################################################################################################################


elif [[ $ARBRE == 'abr' ]]; then 


	######################################################################################################################################
	#-----------------------------------------------------NO LOCATIONS AND NO DATE-------------------------------------------------------#
	######################################################################################################################################


	if [[ $LOCATION == '0' && $DATE != '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 > windspeed.txt

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-------------------------------------------------------DATE WITHOUT LOCATIONS-------------------------------------------------------#
	######################################################################################################################################


	elif [[ $LOCATION == '0' && $DATE == '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,5 > windspeed.txt

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-----------------------------------------------------------ERROR REPORT-------------------------------------------------------------#
	######################################################################################################################################

		
	#------------------------------------------chek if the number of location options is correct-----------------------------------------#

	elif [[ $LOCATION != '1' ]]; then 
		echo 'ERROR ONLY ONE POSSIBLE LOCATION'
		exit
		
	fi


	######################################################################################################################################
	#-----------------------------------------------------LOCATION WITHOUT DATTE---------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#

	if [[ $LOCATION == '1' && $DATE != '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' meteo_filtered_data_v1.csv > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
						
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' meteo_filtered_data_v1.csv > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' meteo_filtered_data_v1.csv > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' meteo_filtered_data_v1.csv > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' meteo_filtered_data_v1.csv > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' meteo_filtered_data_v1.csv > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		

	######################################################################################################################################
	#-------------------------------------------------------LOCATION WITH DATTE----------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#
		
	elif [[ $LOCATION == '1' && $DATE == '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' filtered_by_date.txt > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
						
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' filtered_by_date.txt > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' filtered_by_date.txt > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' filtered_by_date.txt > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' filtered_by_date.txt > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' filtered_by_date.txt > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		
	fi
	

######################################################################################################################################
#-----------------------------------------------------------AVL OR NO OPTION---------------------------------------------------------#
######################################################################################################################################


else 


	######################################################################################################################################
	#-----------------------------------------------------NO LOCATIONS AND NO DATE-------------------------------------------------------#
	######################################################################################################################################


	if [[ $LOCATION == '0' && $DATE != '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,5 > windspeed.txt

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' meteo_filtered_data_v1.csv | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-------------------------------------------------------DATE WITHOUT LOCATIONS-------------------------------------------------------#
	######################################################################################################################################


	elif [[ $LOCATION == '0' && $DATE == '2' ]]; then

		for string in "$@"; do
		
			#WIND
			if [[ $string =~ '-w' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,4 > winddirection.txt
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,5 > windspeed.txt

			#HEIGHT
			elif [[ $string =~ '-h' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,14 > height.txt

			#MOISTURE
			elif [[ $string =~ '-m' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,6 > moisture.txt

			#TEMPERATURE
			elif [[ $string =~ '-t1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,11 > temp1.txt
				
			elif [[ $string =~ '-t2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp2.txt
				
			elif [[ $string =~ '-t3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,11 > temp3.txt

			#PRESSURE
			elif [[ $string  =~ '-p1' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,7 > pressure1.txt
				
			elif [[ $string  =~ '-p2' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure2.txt
				
			elif [[ $string  =~ '-p3' ]]; then
				sed -n '1!p' filtered_by_date.txt | cut -d ';' -f 1,2,7 > pressure3.txt
				
			fi 
			
		done
		
		
	######################################################################################################################################
	#-----------------------------------------------------------ERROR REPORT-------------------------------------------------------------#
	######################################################################################################################################

		
	#------------------------------------------chek if the number of location options is correct-----------------------------------------#

	elif [[ $LOCATION != '1' ]]; then 
		echo 'ERROR ONLY ONE POSSIBLE LOCATION'
		exit
		
	fi


	######################################################################################################################################
	#-----------------------------------------------------LOCATION WITHOUT DATTE---------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#

	if [[ $LOCATION == '1' && $DATE != '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' meteo_filtered_data_v1.csv > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
					
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' meteo_filtered_data_v1.csv > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' meteo_filtered_data_v1.csv > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' meteo_filtered_data_v1.csv > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' meteo_filtered_data_v1.csv > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' meteo_filtered_data_v1.csv > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		

	######################################################################################################################################
	#-------------------------------------------------------LOCATION WITH DATTE----------------------------------------------------------#
	######################################################################################################################################


	#-------------------------------------------------------FRENCH_METROPOLITAN----------------------------------------------------------#
		
	elif [[ $LOCATION == '1' && $DATE == '2' ]]; then

		for string in "$@"; do

			if [[ $string  =~ '-F' ]]; then
				grep -e '^07' filtered_by_date.txt > French.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 French.txt > winddirection.txt
						cut -d ';' -f 1,5 French.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 French.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 French.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 French.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 French.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 French.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 French.txt > pressure3.txt
						
					fi 
				done
				
				
	#-------------------------------------------------------------GUYANA-----------------------------------------------------------------#


			elif [[ $string  =~ '-G' ]]; then
				grep -e '^81' filtered_by_date.txt > Guyana.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Guyana.txt > winddirection.txt
						cut -d ';' -f 1,5 Guyana.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Guyana.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Guyana.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Guyana.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Guyana.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Guyana.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Guyana.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------SAINT_PIERRE_AND_MIQUELON-----------------------------------------------------#


			elif [[ $string  =~ '-S' ]]; then
				grep -e '^71' filtered_by_date.txt > Saint_Pierre.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Saint_Pierre.txt > winddirection.txt
						cut -d ';' -f 1,5 Saint_Pierre.txt > windspeed.txt
						
					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Saint_Pierre.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Saint_Pierre.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Saint_Pierre.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Saint_Pierre.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Saint_Pierre.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Saint_Pierre.txt > pressure3.txt
						
					fi 
				done
				

	#------------------------------------------------------------ANTILLES----------------------------------------------------------------#
					
					
			elif [[ $string  =~ '-A' ]]; then
				grep -e '^78' filtered_by_date.txt > Antilles.txt

				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antilles.txt > winddirection.txt
						cut -d ';' -f 1,5 Antilles.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antilles.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antilles.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antilles.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antilles.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antilles.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antilles.txt > pressure3.txt
						
					fi 
				done
				
				
	#------------------------------------------------------------INDIAN_OCEAN------------------------------------------------------------#


			elif [[ $string  =~ '-O' ]]; then
				grep -e '^61' filtered_by_date.txt > Indian_Ocean.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Indian_Ocean.txt > winddirection.txt
						cut -d ';' -f 1,5 Indian_Ocean.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Indian_Ocean.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Indian_Ocean.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Indian_Ocean.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Indian_Ocean.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Indian_Ocean.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Indian_Ocean.txt > pressure3.txt
						
					fi 
				done


	#------------------------------------------------------------ANTARCTICA--------------------------------------------------------------#


			elif [[ $string  =~ '-Q' ]]; then
				grep -e '^89' filtered_by_date.txt > Antartica.txt
				
				for string in "$@"; do

					#WIND
					if [[ $string =~ '-w' ]]; then
						cut -d ';' -f 1,4 Antartica.txt > winddirection.txt
						cut -d ';' -f 1,5 Antartica.txt > windspeed.txt

					#HEIGHT
					elif [[ $string =~ '-h' ]]; then
						cut -d ';' -f 1,14 Antartica.txt > height.txt

					#MOISTURE
					elif [[ $string =~ '-m' ]]; then
						cut -d ';' -f 1,6 Antartica.txt > moisture.txt

					#TEMPERATURE
					elif [[ $string =~ '-t1' ]]; then
						cut -d ';' -f 1,11 Antartica.txt > temp1.txt
						
					elif [[ $string =~ '-t2' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp2.txt
						
					elif [[ $string =~ '-t3' ]]; then
						cut -d ';' -f 1,2,11 Antartica.txt > temp3.txt

					#PRESSURE
					elif [[ $string  =~ '-p1' ]]; then
						cut -d ';' -f 1,7 Antartica.txt > pressure1.txt
						
					elif [[ $string  =~ '-p2' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure2.txt
						
					elif [[ $string  =~ '-p3' ]]; then
						cut -d ';' -f 1,2,7 Antartica.txt > pressure3.txt
						
					fi 
				
				done

			fi

		done
		
	fi
	
fi
#fi
