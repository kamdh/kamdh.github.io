M=100000;

sample_list=rand(1,M);

[nlist,centerlist]=hist(sample_list);
deltac=centerlist(2)-centerlist(1);

figure
bar(centerlist,nlist/(M*deltac));

