function result = liesInRegion(point, mval1, mval2, x,  eqn1, eqn2)
%Returns if the point lies in region of the meanPoint
   val1 = subs(eqn1,x,point);
   val2 = subs(eqn2,x,point);
  % val3 = subs(eqn3,x,point);
   
  % mVal1 = subs(eqn1,x,meanPoint);
  % mVal2 = subs(eqn2,x,meanPoint);
  % mVal3 = subs(eqn3,x,meanPoint);
   
   if(haveSameSign(val1,mval1) && haveSameSign(val2, mval2))
       result = true;
   else
       result = false;
   end
end