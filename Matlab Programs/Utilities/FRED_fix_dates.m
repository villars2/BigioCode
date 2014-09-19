% FRED_fix_dates
switch lower(date_types)
    case {'all'};
        pdate =dates_t;
        pindex=index_t;
    case {'gr','great recession'}
        pdate =dates_gr;
        pindex=index_gr;
    case {'dec','decade'}
        pdate =dates_d;
        pindex=index_d;
end