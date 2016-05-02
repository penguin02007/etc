##	Favorite Splunk Commands

###	Seach command history
| history 

##	VMware ESX
###	Create a Timechart with Number of Drop frame in the past 48 hours
index=esx earliest=-48h process=vmkwarning FRAME DROP event has been observed | timechart dc(host) as host_count

### Daily event count when syslog is unavailable
index=esx earliest="11/30/2014:00:00:00" latest="12/09/2014:00:00:00"  host syslog.example.com:1514 become unreachable | timechart span=1d count

### Regular Expression
index=esx deteriorated | regex _raw="to \d{3,}"

### Date range
earliest="12/14/2014:00:00:00" latest="12/14/2014:00:00:00"

##	Linux - dsmsched.log
###	Aggregate data transfer rate
index=linux earliest=-1d ("Aggregate data transfer rate" OR "Total number of bytes transferred") | rex field=_raw "Aggregate data transfer rate: (?<AggregateTransfer>.*)KB\/sec" | rex field=_raw "Total number of bytes transferred: (?<TotalTransfer>.*)" | table host, AggregateTransfer,TotalTransfer

### Linux - top
index=linux earliest=-30m source=top | where pctCPU > 30 | stats avg(pctCPU) AS avg_percent_cpu by host, COMMAND| sort -avg_percent_cpu | rex mode=sed field=host "s/.example.com//g" | rex mode=sed field=COMMAND "s/(hdb|controller|spooler)/nimsoft::\1/g" | eval host = upper(host) | rename COMMAND AS process | eval avg_percent_cpu = round(avg_percent_cpu)

## Windows
###	Get bad password
index=wineventlog earliest=-6h Keywords="Audit Failure" bad password | stats count by Workstation_Name | sort -count

### Powershell
index = powershell earliest=-30m | where percent_free_space > 60 | table system_name drive_letter label capacity_gb gb_free_space percent_free_space

##	Generic
### Monitor inactive host
| metadata type=hosts | sort – recentTime | convert timeformat="%Y/%m/%d %H:%M:%S" ctime(recentTime) as Latest_Time

##	Troubleshooting
###	Create Diagnostic bundle
splunk diag
###	Syntax check
splunk btool check --debug
###	Query global indexes.conf
splunk btool --debug indexes list
###	Verify index 
splunk add oneshot /tmp/foo.log -sourcetype foo -host foo -index bar
###	List monitoring files /directories
splunk list monitor
### list all index
| eventcount summarize=false index=* | dedup index | fields index
### Reload conf file without restarting indexer
#### http://splunk-base.splunk.com/answers/5838/can-inputsconf-be-reloaded-without-restarting-splunkd?page=1&focusedAnswerId=8455#8455
http://<url>/debug/refresh