# --- Day 1: Report Repair ---
#
# After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.
#
# The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.
#
# To save your vacation, you need to get all fifty stars by December 25th.
#
# Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
#
# Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
#
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.
#
# For example, suppose your expense report contained the following:
#
# 1721
# 979
# 366
# 299
# 675
# 1456
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
#
# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

sum = 2020

ENTRIES = DATA.map { |e| e.to_i }

ENTRIES.each_with_index do |a, i|
  ENTRIES.each_with_index do |b, j|
    next if i == j  # Don't add an entry to itself
    if b == 2020 - a
      puts "#{a} + #{b} = #{a + b}"
      puts "#{a} * #{b} = #{a * b}"
    end
  end
end

# Your puzzle answer was 1015476.
#
# The first half of this puzzle is complete! It provides one gold star: *
#
# --- Part Two ---
#
# The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.
#
# Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
#
# In your expense report, what is the product of the three entries that sum to 2020?

ENTRIES.each_with_index do |a, i|
  ENTRIES.each_with_index do |b, j|
    next if j == i
    ENTRIES.each_with_index do |c, k|
      next if k == i || k == j  # Don't add an entry to itself
      if c == 2020 - a - b
        puts "#{a} + #{b} + #{c} = #{a + b + c}"
        puts "#{a} * #{b} * #{c} = #{a * b * c}"
      end
    end
  end
end

__END__
1780
1693
1830
1756
1858
1868
1968
1809
1996
1962
1800
1974
1805
1795
170
1684
1659
1713
1848
1749
1717
1734
956
1782
1834
1785
1786
1994
1652
1669
1812
1954
1984
1665
1987
1562
2004
2010
1551
961
1854
2005
1883
1965
475
1776
1791
262
1912
1227
1486
1989
1857
825
1683
1991
1875
1982
1654
1767
1673
1973
1886
1731
1745
1770
1995
1721
1662
1679
1783
1999
1889
1746
1902
2003
1698
1794
1798
1951
1953
2007
1899
1658
1705
62
1819
1708
1666
2006
1763
1732
1613
1841
1747
1489
1845
2008
1885
2002
1735
1656
1771
1950
1704
1737
1748
1759
1802
2000
1955
1738
1761
1765
1853
1900
1709
1979
1911
1775
1813
1949
1966
1774
1977
1757
1992
2009
1956
1840
1988
1985
1993
1718
1976
1078
1997
1897
1792
1790
1801
1871
1727
1700
1485
942
1686
1859
1676
802
1952
1998
1961
1844
1808
1703
1980
1766
1963
1849
1670
1716
1957
1660
1816
1762
1829
526
359
2001
1874
1778
1873
1511
1810
1699
1970
1690
1978
1892
1691
1781
1777
1975
1967
1694
1969
1959
1910
1826
1672
1655
1839
1986
1872
1983
1981
1972
1772
1760