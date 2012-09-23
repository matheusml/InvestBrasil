#encoding: utf-8

module CommentsHelper
	def placeholder_condition user
		if user
			'Entre com seu comentário'
		else
			'Cadastre-se para poder comentar'
		end
	end

	def disabled? user
		if user
			''
		else
			'disabled'
		end
	end

	def disabled_if_no_user user
		if user
			false
		else
			true
		end
	end
end
