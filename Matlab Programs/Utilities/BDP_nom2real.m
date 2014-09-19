for ii=1:numel(n2rlist)
    eval(['R' char(n2rlist(ii)) '=' char(n2rlist(ii)) './GDPDEF;' ]);
end
