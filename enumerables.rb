# ITERATION EXCERCISES
# ENUMERABLE

# Extend the Array class to include a method named my_each that takes a block, calls the block on every element of the array, and returns the original array. Do not use Enumerable's each method. I want to be able to write:
class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            ele=self[i]
            prc.call(ele)
            i+=1
        end
        self
    end 
end

# #  calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#     #  2
#     #  3
#     #  1
#     #  2
#     #  3

# p return_value  # => [1, 2, 3]



# My Select
# Now extend the Array class to include my_select that takes a block and returns a new array containing only elements that satisfy the block. Use your my_each method!

class Array
    def my_select(&prc)
        selected = []
        i = 0
        while i < self.length
            el = self[i]
            selected << el if prc.call(el)
             i += 1
        end
        selected
    end
end

# # Example:
# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []



# My Reject
# Write my_reject to take a block and return a new array excluding elements that satisfy the block.
class Array
    def my_reject(&prc)
        rejected=[]
        i=0
        while i < self.length
            ele = self[i]
            rejected << ele if !prc.call(ele)
            i += 1
        end
        rejected
    end
end
# Example:
# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]



# My Any
# Write my_any? to return true if any elements of the array satisfy the block and my_all? to return true only if all elements satisfy the block.

class Array
    def my_any?(&prc)
        self.each { |el| return true if prc.call(el) }
        false
    end

    def my_all?(&prc)
        # count = 0
        # self.each do |el|
        #     count += 1 if prc.call(el)
        # end
        # count == self.length
        self.count { |el| prc.call(el) } == self.length
    end
end

# Example:
# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true


# Array
# My Flatten
# my_flatten should return all elements of the array into a new, one-dimensional array. Hint: use recursion!
class Array
    def my_flatten
        # base case
        return [] if self.empty?
        
        # generalized
        flattened=[]
        self.each do |ele|
            # if they are NOT an array - what can we do
            if !ele.is_a?(Array)
                flattened << ele 
            # if they are an array - what can we do
            else
                flattened += ele.my_flatten       # here ele is an array
            end
        end
        flattened
        # self.each do |row|
        # my_flatten(row)
    end
end
# Example:
# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
#   [ 1, 2, 3,
#   [ 4, [5, 6]],
#   [[[ 7 ]], 8 ]]



# My Zip
# Write my_zip to take any number of arguments. It should return a new array containing self.length elements. Each element of the new array should be an array with a length of the input arguments + 1 and contain the merged elements at that index. If the size of any argument is less than self, nil is returned for that location.
class Array
    def my_zip(*arrs)
        arr=[]
        (0...self.length).each do |i|
            empty_arr=[]
            empty_arr << self[i]
            arrs.each do |sub_arr|
                empty_arr << sub_arr[i]
            end
            arr << empty_arr
        end
        arr
    end
end
# Example:
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]



# My Rotate
# Write a method my_rotate that returns a new array containing all the elements of the original array in a rotated order. By default, the array should rotate by one element. If a negative value is given, the array is rotated in the opposite direction.


class Array
    def my_rotate(n=1)
        arr1 = self.dup
        if n > 0
            n.times do
                el = arr1.shift
                arr1.push(el)
            end
        else
            n = -n
            n.times do
                el = arr1.pop
                arr1.unshift(el)
            end
        end
        arr1
    end
end
# Example:

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]



# My Join
# my_join returns a single string containing all the elements of the array, separated by the given string separator. If no separator is given, an empty string is used.



class Array
    def my_join(el="")
        new_str = ""
        self.each_with_index do |char, i|
            if i == self.length - 1 
                new_str += char
            else
                new_str += char + el
            end
        end
        new_str
        # self.map.with_index { |char, i| i == self.length - 1 ? char : char + el }.join("")
    end
end


# Example:

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"




# My Reverse
# Write a method that returns a new array containing all the elements of the original array in reverse order.

# Example:

# [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# [ 1 ].my_reverse               #=> [1]
# Review
# Now that we're all warmed up, let's review the iteration exercises from the prepwork. Implement the following methods:

# #factors(num)
# #bubble_sort!(&prc)
# #bubble_sort(&prc)
# #substrings(string)
# #subwords(word, dictionary)
# Although these exercises are from the prepwork and come with specs, use this opportunity to practice your own testing skills. Write out each method, think of a few different example cases, and test out your code in pry.

# If you are having a tough time thinking of example cases, check out the specs. You can use those examples to test your solutions. Don't forget to move your enumerables_array.rb into a lib directory!