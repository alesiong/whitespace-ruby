class WhiteSpace
	def initialize(file = "tmp.ws", &block)
		@f = open(file,"w")
		instance_eval &block
		#@f.print "\n\n\n"
		@f.close
		exec "ruby whitespace.rb < #{file}"
	end

	def trans_signed num
		rtn = ""
		rtn << (num > 0 ? " " : "\t")
		rtn << num.to_s(2).tr("01"," \t")
		rtn
	end

	def trans_unsigned num
		rtn = ""
		rtn << num.to_s(2).tr("01"," \t")
		rtn
	end

	def trans_label label
		rtn = ""
		rtn << label.to_s.hash.abs.to_s(2).tr("01"," \t")#label.to_s.each_char.collect{|c| c.ord}.inject(:+).to_s(2).tr("01"," \t")
		rtn
	end

	def push num
		@f.print "  "
		@f.print trans_signed num
		@f.print "\n"
	end

	def dup num = nil
		if num == nil
			@f.print " \n "
		else
			@f.print " \t "
			@f.print trans_unsigned num
			@f.print "\n"
		end
	end

	def swap
		@f.print " \n\t"
	end

	def discard num = nil
		if num == nil
			@f.print " \n\n"
		else
			@f.print " \t\n"
			@f.print trans_unsigned num
			@f.print "\n"
		end
	end

	[["\t   ", :add],
  ["\t  \t", :sub],
  ["\t  \n", :mul],
  ["\t \t ", :div],
  ["\t \t\t", :mod],
  ["\t\t ", :store],
  ["\t\t\t", :load],
	["\n\t\n", :ret],
  ["\n\n\n", :exit],
  ["\t\n  ", :printchar],
  ["\t\n \t", :printnum],
  ["\t\n\t ", :readchar],
  ["\t\n\t\t", :readnum]].each{|ops|
		define_method ops[1] {
			@f.print ops[0]
		}
	}

	[["\n  ", :label],
  ["\n \t", :call],
  ["\n \n", :jump],
  ["\n\t ", :jz],
  ["\n\t\t", :jn]].each{|ops|
		define_method ops[1] {|label|
			@f.print ops[0]
			@f.print trans_label label
			@f.print "\n"
		}
	}

end

#fac 1=1
#fac n=n*fac (n-1)
