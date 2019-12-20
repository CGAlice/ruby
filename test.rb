def get_all_patturn(cx_count,deck_sum)
  ret=[]
  if cx_count==1
    for i in 1..deck_sum
      ret<<[i]
    end
    return ret
  else
    for i in 1..deck_sum
      for ind in get_all_patturn(cx_count-1,deck_sum-i)
        ret << ind.push(deck_sum-i+1)
      end
    end
  end
  ret
end

te= get_all_patturn(3,8)
p te
p te.length()
