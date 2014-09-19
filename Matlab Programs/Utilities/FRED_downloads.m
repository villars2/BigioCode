if license('test', 'datafeed_toolbox')

	% Load data from FRED and convert to quarterly periodicity
	% Note that dates are start-of-period dates in the FRED database
	
	fprintf('Loading time series data from St. Louis Federal Reserve (FRED) ...\n');
         
	% Obtain data with "try-catch" and load Data_USEconModel.mat if problems occur
	
	try
		Universe = [];

		% Open a Datafeed Toolbox connection to FRED
		
		c = fred;
       
		for i = 1:numel(series)
            
			fprintf('Started loading %s ... ',series{i});

			% Fetch data from FRED
			
			FredData = fetch(c, series{i});

			% Dates are start-of-period dates so move to end-of-period date			
			offset = 1;
			if strcmpi(strtrim(FredData.Frequency),'Quarterly')
				offset = 2;
			elseif strmatch('Mar', strtrim(FredData.Frequency))
				offset = 2;
			else
				offset = 0;
			end

			% Set up dates			
			dates = FredData.Data(:,1);

			mm = month(dates) + offset;
			yy = year(dates);
			for t = 1:numel(dates)
				if mm(t) > 12
					mm(t) = mm(t) - 12;
					yy(t) = yy(t) + 1;
				end
			end
			dates = lbusdate(yy, mm);
			
			% Set up data			
			Data = FredData.Data(:,2);

			% Create financial time series			
			fts = fints(dates, Data, series{i});
			
			% Convert to quarterly periodicity			
			if strcmpi(strtrim(FredData.Frequency), 'Quarterly')
				fprintf('Quarterly ... ');
			elseif strmatch('Mar', strtrim(FredData.Frequency))
				fprintf('Quarterly ... ');
			else
				fprintf('Monthly ... ');
				fts = toquarterly(fts);
			end

			% Combine time series			
			Universe = merge(fts, Universe);
			fprintf('Finished loading %s ...\n',series{i});
            
        end        
		close(c);
		
		Universe.desc = 'U.S. Macroeconomic Data';
		Universe.freq = 'quarterly';

		% Trim date range to period from 1947 to present		
		StartDate = datenum(Universe.dates(1));
		EndDate = datenum(Universe.dates(end));

		Universe = Universe([datestr(StartDate,1) '::' datestr(EndDate,1)]);
		
		% Convert combined time series into date and data arrays		
		dates = Universe.dates;
		Data = fts2mat(Universe.(series));
		Dataset = dataset([{Data},series],'ObsNames',cellstr(datestr(dates,'QQ-YYYY')));
		
		% Uncomment next line to save data in mat doc Data_USEconModelUpdate.mat		
		% save FRED_TFP_accounting_data.mat series dates Data Dataset
        
	catch E
		
		% Case with no internet connection
		
		fprintf('Unable to connect to FRED. Will use local data.\n');
        fprintf('Loading data from older downloads...\n');
%		load('FRED_TFP_accounting_data.mat')
       % break
    end
    
    %
else
	
	% Case with no Datafeed Toolbox	
    fprintf('Unable to connect to FRED. Will use local data.\n');
    fprintf('Loading data from older downloads...\n');
    load('FRED_TFP_accounting_data.mat')
   % break
    
end