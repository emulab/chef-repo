#
# Cookbook Name:: emulab-slurm
# Recipe:: example
#

# Only install example on the head node
if node['hostname'] == node["slurm"]["control_machine"]

  # mpirun is required to run tasks accross a number of processors
  # mpicc is required for compilation
  include_recipe "emulab-openmpi"
  
  # This example requires SLURM accounting (default account needs to be associated with partition, cluster, etc.)
  include_recipe "emulab-slurm::accounting"
  
  dest=node["slurm"]["scratch"]
  user=node["slurm"]["user"]
  
  # Create necessary directories
  directory dest do
    owner user
    group user
  end
  
  program="mpihelloworld"
  
  # Create the program
  template "#{dest}/#{program}.c" do
    source "#{program}.erb"
    owner user
    group user
  end
  
  # Create submission script
  template "#{dest}/#{program}.pbs" do
    source "slurm_example.pbs.erb"
    owner user
    group user
    variables(
      :dir => dest,
      :program => program,
      :ntasks => node["cpu"]["total"],
      :account => node["slurm"]["account_name"])
  end
  
  log "Example is created. Now, compile and submit by hand." 
  log "Follow these steps:
      su - #{user}
      cd #{dest}
      source /etc/profile
      mpicc #{program}.c -w -o #{program}
      sbatch #{program}.pbs
      ## And you are done: the job is in the queue now. You should have a working SLURM cluster.
      ## To see the output and possible errors: cat #{program}.out #{program}.err
      ## To see all previous jobs: sacct
      ## To see the status of the cluster: sinfo -Nel
      "
end
