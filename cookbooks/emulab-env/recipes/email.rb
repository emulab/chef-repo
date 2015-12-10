#
# Cookbook Name:: emulab-env
# Recipe:: email
#

# Configuration allowing to email the experiment owner 
bash 'Set SWAPPER_EMAIL permanently in /etc/profile.d/emulab-email.sh' do
  code <<-EOH
    BOOTDIR=/var/emulab/boot ; 
    SWAPPER=`cat $BOOTDIR/swapper` ; 
    if [ "$SWAPPER" = "geniuser" ] ; then  
      SWAPPER_EMAIL=`geni-get slice_email`  
    else  
      SWAPPER_EMAIL="$SWAPPER@$OURDOMAIN" 
    fi ; 
    echo "export SWAPPER_EMAIL=$SWAPPER_EMAIL" > /etc/profile.d/emulab-email.sh
  EOH
  not_if { ::File.exist?("/etc/profile.d/emulab-email.sh") }
end

# dma - DragonFly Mail Agent - allows sending emails
package "dma"

# After setting SWAPPER_EMAIL and installing the package,
# do this to send an email to the owner:
# $ echo "BODY" | mail -s "SUBJECT" ${SWAPPER_EMAIL} &
