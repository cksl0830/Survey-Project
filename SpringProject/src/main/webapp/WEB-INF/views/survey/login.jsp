<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container tm-mt-big tm-mb-big">
	<div class="row">
		<div class="col-12 mx-auto tm-login-col">
			<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
				<div class="row">
					<div class="col-12 text-center">
						<h2 class="tm-block-title mb-4">로그인</h2>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col-12">
						<form action="loginCheck" method="post" class="tm-login-form">
							<div class="form-group">
								<label for="username">아이디</label> <input name="username"
									type="text" class="form-control validate" id="username"
									value="" required />
							</div>
							<div class="form-group mt-3">
								<label for="password">비밀번호</label> <input name="password"
									type="password" class="form-control validate" id="password"
									value="" required />
							</div>
							<div class="form-group mt-4">
								<button type="submit" class="btn btn-primary btn-block text-uppercase">로그인</button>
								<br>
								<div class="media-body"><a href="/survey/foundPassword"><h2 class="tm-block-title" style="float: right">비밀번호 찾기</h2></a></div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>