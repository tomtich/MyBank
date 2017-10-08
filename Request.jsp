<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload Profile</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<!--  <script type="text/javascript" src="js/petstore.js"></script>-->

   <!-- <script type="text/javascript">
		//EL code you can write inside the JSP so we cannot put below line in JS file...
		var contextPath="${pageContext.request.contextPath}";
	</script>

	<script type="text/javascript">
		//EL code you can write inside the JSP so we cannot put below line in JS file...
		var contextPath="${pageContext.request.contextPath}";
	</script>
<script type="text/javascript" src="js/customer.js"></script>
<script type="text/javascript" src="js/init.js"></script>
 -->   
</head>
<body>
<img alt="" src="${pageContext.request.contextPath}/img/request.png" height="120px;" style="width: 100px;display: inline;margin-left: 40px;">
	<span style="color: #4000ff;font-size: 20px;">${message}</span>
	<hr style = "border-width: 10px;"/>
    <div style="background-color:#ffe6e6;margin-right: 400px;">
    <form action="${pageContext.request.contextPath}/uploadCustomer" method="POST" name = "pendingForm" id = "pendingForm">
    	 
   <table>
    	<tr>
    	<td><br>
        <div class="form-group">
            <label style="display: inline;margin-left: 20px;">Name  : </label>
            <input type="text" class="form-control"  name="name" id = "name" placeholder="Name" style="width: 300px;display: inline;margin-left: 40px;"/>
              <br/>   <br/>
        </div>
        <div class="form-group">
            <label style="display: inline;margin-left: 20px;">Age :</label>
            <input type="text" class="form-control"  name="age" id = "age" placeholder="Age" style="margin-left: 40px;width: 240px;display: inline;margin-right: 40px;" ng-model="email"/>
              <br/>   <br/>
        </div>
        
          <div class="form-group">
            <label style="display: inline;margin-left: 20px;">Contack Number :</label>
             <input type="text" name="contactNumber" id = "contactNumber" placeholder="Contact Number" class="form-control" style="margin-left: 40px;width: 240px;display: inline;margin-right: 40px;">
               <br/>   <br/>
        </div>
           
           
        
           <div class="form-group">
            <label style="display: inline;margin-left: 20px;">Loan Amount : $</label>
             <input type="text" name="loanAmount" id = "loanAmount" placeholder="Loan Amount" class="form-control" style="margin-left: 40px;width: 240px;display: inline;margin-right: 40px;">
               <br/>   <br/>
        </div>
           <div class="form-group">
            <label style="display: inline;margin-left: 20px;">SSN :</label>
             <input type="password" name="ssn" id = "ssn" placeholder="Social Number" class="form-control" style="margin-left: 40px;width: 240px;display: inline;margin-right: 40px;">
               <br/>   <br/>
        </div>
        
        
          <button type="submit" id ="showdata" class="btn btn-danger" style="display: inline;margin-left: 100px;" >Send Request</button>
        <button type="button" id = "resetdata" class="btn btn-danger" style="display: inline;margin-left: 100px;">Reset</button>
         </td>
         </tr>
        
        </table>
    </form>
    <br/>
    </div>
</body>
</html>