_isort_apply:
	isort ./DiffusionPO ./tests ./demo

_black_apply:
	black ./DiffusionPO ./tests ./demo

fmt:
	make _black_apply _isort_apply

test:
	pytest