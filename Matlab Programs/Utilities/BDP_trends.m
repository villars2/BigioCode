
for ii=1:numel(varlist)-1
%     eval([char(varlist(ii)) '_g= [mean(diff(log(R' char(varlist(ii)) '(1:5))))   ; diff(log(R' char(varlist(ii)) '))];' ]);
    eval([char(varlist(ii)) '_g= [diff(log(' char(varlist(ii)) '(1:5)))   ; diff(log(' char(varlist(ii)) '))];' ]);   
    eval(['range            = isfinite(' char(varlist(ii)) ');']);
    %eval(['[hp_' char(varlist(ii)) ',c_' char(varlist(ii))  ']=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
    
    eval(['[hp_aux,c_aux]=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
    eval(['hp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['c_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['hp_' char(varlist(ii)) '(range)=[hp_aux];']);
    eval(['c_' char(varlist(ii)) '(range)=[c_aux];']);
    %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
    eval(['l_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
    eval(['lhp_' char(varlist(ii)) '= log(hp_' char(varlist(ii)) ');']);
    eval(['devhp_' char(varlist(ii)) '= log(c_' char(varlist(ii)) './hp_' char(varlist(ii)) '+1);']);
    
    % Band-Pass Filter
%    [fX] = bandpass(X,pl,pu)
    eval(['[cp_aux]=bpass(' char(varlist(ii)) '(range),pl,pu);']);
    eval(['bp_aux=' char(varlist(ii)) '(range)-cp_aux;']);
    eval(['bp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['cp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['bp_' char(varlist(ii)) '(range)=[bp_aux];']);
    eval(['cp_' char(varlist(ii)) '(range)=[cp_aux];']);
    
    %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
%     eval(['l_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
%     eval(['lhp_' char(varlist(ii)) '= log(hp_' char(varlist(ii)) ');']);
    eval(['devbp_' char(varlist(ii)) '= log(cp_' char(varlist(ii)) './bp_' char(varlist(ii)) '+1);']);
    
    % First Real
    % Pick the first element
    firstdate=0;
    if firstdate==1
        eval(['init_aux=min(index_s(logical(1-isnan(' char(varlist(ii)) '))));']);    
    else
        init_aux=min(index_s(logical(dates>initlindate)));    
    end
    eval(['lt_' char(varlist(ii)) '= (l_' char(varlist(ii)) '(DateEndTrend)-l_' char(varlist(ii)) '(init_aux))*((init_aux:T)-init_aux)/(DateEndTrend-init_aux)+l_' char(varlist(ii)) '(init_aux);']);    
    eval(['lt_' char(varlist(ii)) '=[NaN(init_aux-1,1); lt_' char(varlist(ii)) '''];']);
    eval(['ldev_' char(varlist(ii)) '= log(' char(varlist(ii)) ')-lt_' char(varlist(ii)) ';']);
    
    % Auxiliary Data
    eval([char(varlist(ii)) '_art=l_' char(varlist(ii)) ';']);
    eval([char(varlist(ii)) '_art(init_aux:end)=lt_' char(varlist(ii)) '(init_aux:end);']);
    eval(['[hp_aux,c_aux]=hpfilter_ext(' char(varlist(ii)) '_art(range),lambda_hp);' ]);
    eval(['hpart_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['cart_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
    eval(['hpart_' char(varlist(ii)) '(range)=[hp_aux];']);
    eval(['cart_' char(varlist(ii)) '(range)=l_' char(varlist(ii)) '(range)-hp_aux;']);
    %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
%     eval(['lart_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
%     eval(['lhpart_' char(varlist(ii)) '= log(hpart_' char(varlist(ii)) ');']);
    eval(['devhpart_' char(varlist(ii)) '= (cart_' char(varlist(ii)) ');']);
end 