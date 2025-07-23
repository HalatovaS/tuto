#!/bin/sh

# SLURM options:

#SBATCH --job-name=Bi214_job
#SBATCH --mem=10G
#SBATCH --licenses=sps

#SBATCH --time=10:00
#SBATCH --cpus-per-task=1


source ${THRONG_DIR}/config/supernemo_profile.bash   # load Falaise
snswmgr_load_setup falaise@5.1.2
snswmgr_load_stack base@2024-09-04



/sps/nemo/sw/redhat-9-x86_64/snsw/opt/falaise-5.1.2/bin/flsimulate -c /pbs/home/o/ohalatova/tutorial/Bi214/Simu_Bi214.conf -o /pbs/home/o/ohalatova/tutorial/Bi214/Simu_Bi214_new.brio

CONF_FAL="/sps/nemo/sw/Falaise/install_develop/share/Falaise-4.1.0/resources/snemo/demonstrator/reconstruction/"

# CONF_FAL = "path to my Falaise configuration file"

/sps/nemo/sw/redhat-9-x86_64/snsw/opt/falaise-5.1.2/bin/flreconstruct -i /pbs/home/o/ohalatova/tutorial/Bi214/Simu_Bi214_new.brio -p $CONF_FAL/official-2.0.0.conf -o /pbs/home/o/ohalatova/tutorial/Bi214/Reco_Bi214_new.brio

/sps/nemo/sw/redhat-9-x86_64/snsw/opt/falaise-5.1.2/bin/flreconstruct -i /pbs/home/o/ohalatova/tutorial/Bi214/Reco_Bi214_new.brio -p /pbs/home/o/ohalatova/MiModule/p_MiModule_v00.conf
