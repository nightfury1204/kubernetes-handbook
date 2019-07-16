Rob Skillington @robskillington 12:00
@N_A_Nahid_twitter here it is m3db/m3#1741(https://github.com/m3db/m3/pull/1741)
@evanhuang996_twitter it's for clustered aggregation (so if you are using aggregated namespaces or M3 rollup rules you can scale out your m3coordinators without worrying about them keeping aggregation state)

Evanhuang @evanhuang996_twitter 12:02
that's good
we can set up a HA solution then
where is the m3aggregator binary file?

Rob Skillington @robskillington 12:07
oh weird, we don't actually publish the docker image just yet
but you can make with make m3aggregator

signmem @signmem 12:13
where can I find m3aggregator configure example?
I want to test downsampleing function.

Rob Skillington @robskillington 12:17
@signmem for testing we recommend starting with the m3coordinator doing aggregation, here's the docs on that:
https://docs.m3db.io/how_to/query/#aggregation
the query documentation also has the relevant m3coordinator documentation

signmem @signmem 12:26

I have read this document , I doing some test for it.
it my example.
I have one m3coordinator . and it my configure.
 

Rob Skillington @robskillington 12:28
@signmem that looks good
you just need to make sure all those namespaces exist

signmem @signmem 12:32
My understanding is that I write to the m3coordinator ( http://x.x.x.x:7201/api/v1/prom/remote/write) every second.
It will save the data at the expected intervals in different namespace?
yet, all the namespace is created alrealy

signmem @signmem 12:48
but is does work. same inteval metric save in all of the namespace above.

Rob Skillington @robskillington 12:50
correct it should store the data at the "resolution"
in each namespace separately
that's pretty strange that's sending the same resolution to all of them... not sure how that could happen

signmem @signmem 12:55
I create there m3query use for these namespace. so I get the same metric interval from every m3query.

Rob Skillington @robskillington 12:55
@signmem ok yeah, so how the query semantics work
is that depending on your look back period
you'll get the different namespaces returning data
so if you look at less than 72h you'll always get 1s
if you look greater than 72h but less than 168h you'll always get 60s
and if you look at greater than 168h you'll always get 5min resolution
@signmem does that make sense?

signmem @signmem 12:58
Maybe I misunderstood. I thought m3 coordinator would save metrics from different time periods to different namespaces instead of queries