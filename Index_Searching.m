function [ index ] = Index_Searching( value,index_array )
    index = binaraysearchasc(index_array,value);
%     for i = 1:length(index_array)
%         if value == index_array(i)
%             index = i;
%             return
%         end
%     end
end

