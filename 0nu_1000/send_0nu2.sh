#!/bin/sh

# SLURM options:

#SBATCH --job-name=0nu_Se82_1000_job
#SBATCH --mem=10G
#SBATCH --licenses=sps


source ${THRONG_DIR}/config/supernemo_profile.bash   # load Falaise
snswmgr_load_setup falaise@5.1.2

flsimulate -c Simu_0nu_Se82_1000.conf -o Simu_0nu_Se82_1000.brio

CONF_FAL="/sps/nemo/sw/Falaise/install_develop/share/Falaise-4.1.0/resources/snemo/demonstrator/reconstruction/"    # CONF_FAL = "path to my Falaise configuration file"


flreconstruct -i Simu_0nu_Se82_1000.brio -p $CONF_FAL/official-2.0.0.conf -o Reco_0nu_Se82_1000.brio


flreconstruct -i ./tutorial/0nu/0nu_1000/Reco_0nu_Se82_1000.brio -p /pbs/home/o/ohalatova/MiModule/p_MiModule_v00.conf
