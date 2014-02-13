#!/bin/bash
nvjoblist.exe -delimiter , | grep "Exchange Server APM" > exchange_jobs.csv

stopFulls () {
	clear
	echo "Stopping all Full Backups..."
	grep Full exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Stopping Job ID:" $line
			nvjobhold.exe -jobid $line
		done
}
stopIncrs () {
	clear
	echo "Stopping all Incremental Backups..."
	grep Incremental exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Stopping Job ID:" $line
			nvjobhold.exe -jobid $line
		done
}
stopAll () {
	clear
	echo "Stopping all Backups..."
	stopFulls
	stopIncrs
}
startFulls () {
	clear
	echo "Starting all Full Backups..."
	grep Full exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Starting Job ID:" $line
			nvjobresume.exe -jobid $line
		done
}
startIncrs () {
	clear
	echo "Starting all Incremental Backups..."
	grep Incremental exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Starting Job ID:" $line
			nvjobresume.exe -jobid $line
		done
}
startAll () {
	clear
	echo "Starting all Backups..."
	startFulls
	startIncrs
}
startGroup () {
	clear
	echo "Starting group" $1
	grep $1 exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Starting Job ID:" $line
			nvjobresume.exe -jobid $line
		done
}
stopGroup () {
	clear
	echo "Stoping group" $1
	grep $1 exchange_jobs.csv | cut -d "," -f1 | while read line
		do
			echo "Stopping Job ID:" $line
			nvjobhold.exe -jobid $line
		done
}
getStatus () {
	clear
	echo "Current status of jobs:"
	nvjoblist.exe -runinfo | grep Exchange
}

clear
echo "Welcome to the NVBU Awesomator"
select rootMenu in "Get Current Status" "Start Exchange Jobs" "Stop Exchange Jobs" "Control Jobs For Specific Storage Groups" "Exit"; do
	case $rootMenu in
		"Get Current Status" ) getStatus;;
		"Start Exchange Jobs" )
			clear
			select startJobs in "Start Full Backups" "Start Incremental Backups" "Start All Backups" "Exit"; do
				case $startJobs in
					"Start Full Backups" ) startFulls;;
					"Start Incremental Backups" ) startIncrs;;
					"Start All Backups" ) startAll;;
					"Exit" ) exit;;
				esac
				exit
			done
		;;
		"Stop Exchange Jobs" )
			clear
			select startJobs in "Stop Full Backups" "Stop Incremental Backups" "Stop All Backups" "Exit"; do
				case $startJobs in
					"Stop Full Backups" ) stopFulls;;
					"Stop Incremental Backups" ) stopIncrs;;
					"Stop All Backups" ) stopAll;;
					"Exit" ) exit;;
				esac
				exit
			done
		;;
		"Control Jobs For Specific Storage Groups" )
			clear
			select groupAction in "Stop Jobs On A Specific Group" "Start Jobs On A Specific Group"; do
				case $groupAction in
					"Stop Jobs On A Specific Group" )
						clear
						select storageGroup in "SG1" "SG2" "SG3" "SG4" "SG5" "SG6" "SG7" "SG8" "SG9" "SG10" "SG11" "SG12" "Public Folders" "Exit"; do
							case $storageGroup in
							"SG1" ) stopGroup "SG1 ";;
							"SG2" ) stopGroup "SG2 ";;
							"SG3" ) stopGroup "SG3 ";;
							"SG4" ) stopGroup "SG4 ";;
							"SG5" ) stopGroup "SG5 ";;
							"SG6" ) stopGroup "SG6 ";;
							"SG7" ) stopGroup "SG7 ";;
							"SG8" ) stopGroup "SG8 ";;
							"SG9" ) stopGroup "SG9 ";;
							"SG10" ) stopGroup "SG10 ";;
							"SG11" ) stopGroup "SG11 ";;
							"SG12" ) stopGroup "SG12 ";;
							"Public Folders" ) stopGroup "Public Folders ";;
							"Exit" ) exit;;
							esac
							REPLY=
						done
					;;	
					"Start Jobs On A Specific Group" )
						clear
						select storageGroup in "SG1" "SG2" "SG3" "SG4" "SG5" "SG6" "SG7" "SG8" "SG9" "SG10" "SG11" "SG12" "Public Folders" "Exit"; do
							case $storageGroup in
							"SG1" ) startGroup "SG1 ";;
							"SG2" ) startGroup "SG2 ";;
							"SG3" ) startGroup "SG3 ";;
							"SG4" ) startGroup "SG4 ";;
							"SG5" ) startGroup "SG5 ";;
							"SG6" ) startGroup "SG6 ";;
							"SG7" ) startGroup "SG7 ";;
							"SG8" ) startGroup "SG8 ";;
							"SG9" ) startGroup "SG9 ";;
							"SG10" ) startGroup "SG10 ";;
							"SG11" ) startGroup "SG11 ";;
							"SG12" ) startGroup "SG12 ";;
							"Public Folders" ) startGroup "Public Folders ";;
							"Exit" ) exit;;
							esac
							REPLY=
						done
					;;
					"Exit" ) exit;;
				esac
			done
		;;
		"Exit" ) exit;;
	esac
	REPLY=
done
#echo "Do you wish to stop Fulls, Incrementals, or All?"
#select ans in "Fulls" "Incrementals" "All" "Exit"; do
#	case $ans in
#		Fulls ) stopFulls;;
#		Incrementals ) echo "incr";;
#		All ) echo "foobar";;
#		Exit ) exit;;
#	esac
#done



#nvjobhold.exe