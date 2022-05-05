function [t, amp1, amp2] = extractData2(file)
data = csvread(append(file, '.csv'));
t = data(:,1);
amp1 = data(:,2);
amp2 = data(:,3);
end