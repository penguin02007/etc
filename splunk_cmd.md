#	Favorite Splunk Commands

##	Seach command history
| history 

##	Drop frame
index=esx host="*" earliest=-48h process=vmkwarning FRAME DROP event has been observed | timechart dc(host) as host_count