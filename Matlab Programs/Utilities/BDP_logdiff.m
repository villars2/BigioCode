for ii=1:numel(varlist)
    eval(['ld_' char(varlist(ii)) '= [mean(diff(log(' char(varlist(ii)) '(1:5))))   ; diff(log(' char(varlist(ii)) '))];' ]);
end