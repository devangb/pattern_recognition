function result = haveSameSign(val1, val2)
%Returns true if val1 and val2 have same sign
   if((val1 > 0 && val2 > 0) || (val1 < 0 && val2 < 0))
       result = true;
   else 
       result = false;
   end
end