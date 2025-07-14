#!/bin/sh

# SLURM options:

#SBATCH --job-name=0nu_Se82_job
#SBATCH --mem=10G
#SBATCH --licenses=sps

#SBATCH --time=10:00
#SBATCH --cpus-per-task=1


source ${THRONG_DIR}/config/supernemo_profile.bash   # load Falaise
snswmgr_load_setup falaise@5.1.2
snswmgr_load_stack base@2024-09-04



/sps/nemo/sw/redhat-9-x86_64/snsw/opt/falaise-5.1.2/bin/flsimulate -c /pbs/home/o/ohalatova/tutorial/0nu/Simu_0nu_Se82.conf -o /pbs/home/o/ohalatova/tutorial/0nu/Simu_0nu_Se82_new.brio

CONF_FAL="/sps/nemo/sw/Falaise/install_develop/share/Falaise-4.1.0/resources/snemo/demonstrator/reconstruction/"



/sps/nemo/sw/redhat-9-x86_64/snsw/opt/falaise-5.1.2/bin/flreconstruct -i /pbs/home/o/ohalatova/tutorial/0nu/Simu_0nu_Se82_new.brio -p $CONF_FAL/official-2.0.0.conf -o /pbs/home/o/ohalatova/tutorial/0nu/Reco_0nu_Se82_new.brio
