function value = Clamp(value, minVal, maxVal)
% CLAMP limits a value between minVal and maxVal

if value < minVal
    value = minVal;
elseif value > maxVal
    value = maxVal;
end

end