<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pending List</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript">
	var contents = "";
	$(document).ready(function() {

		$("#search").click(function() {
			var purl = contextPath + "/customers";
			$.ajax({
				url : purl,
				success : function(jsonData) {
					contents = "";
					for (var x = 0; x < jsonData.length; x++) {
						addOneResult(jsonData[x], x);
						hideRecord(x);
					}
					$("#searchResult").html(contents);
				}
			});
		}); //end of the click event
	}); //end of ready handler

	function hideRecord(id) {
		$("#table" + id).hide();
	}

	function showRecord(id) {
		$("#table" + id).show();
	}

	function hidePending(id) {
		$("#mydiv" + id).hide();
	}

	function rejectPending(id) {
		$("#mydiv" + id).hide();
	}

	function deleteRecord(id) {
		//https://stackoverflow.com/questions/2153917/how-to-send-a-put-delete-request-in-jquery
		var purl = contextPath + "/" + id;
		$
				.ajax({
					url : purl,
					type : 'DELETE',
					success : function(jsonData) { //data= this.responseText
						//data is JavaScript object against JSON response coming fromm the server
						console.log("jsonData.status" + jsonData.status);
						if (jsonData.status == "success") {
							$("#mydiv" + id).hide();
						} else {
							alert("Sorry! data could not be deleted......................................................................");
						}
					}
				});
	}

	function addOneResult(srow, index) {
		contents = contents
				+ '<div id = "mydiv'+ srow.id + '"><h4 style = "color:#4000ff;">Request #'
				+ srow.id
				+ '<a href="javascript:showRecord('
				+ srow.id
				+ ')"><img src="img/show.png" height="30px;"/><a href="javascript:hideRecord('
				+ srow.id
				+ ')"><img src="img/hide.png" height="30px;"/> </h4><br><br><table class="table" style="width: 80%; display:none;"  id="table'
				+ srow.id + '">';
		contents = contents + '  <tbody>';
		contents = contents + '<tr>';
		contents = contents
				+ '<td>Name   :  <span id="name" style="margin-left: 20px;font-size: 15;font-weight: normal;"> '
				+ srow.name + '</span></td>';
		contents = contents
				+ '<td rowspan="5" style="width: 40%;"><a href="javascript:deleteRecord('
				+ srow.id
				+ ')"><img src="img/pending.jpg" height="160px;"/></td>';
		contents = contents + '</tr>';
		contents = contents + '<tr>';
		contents = contents
				+ '<td>Age   :  <span id="age" style="margin-left: 20px;font-size: 15;font-weight: normal;">'
				+ srow.age + '</span></td>';
		contents = contents + '      </tr>';
		contents = contents + '      <tr>';
		contents = contents
				+ '            <td>Contact Number   :  <span id="contactNumber" style="margin-left: 20px;font-size: 15;font-weight: normal;">'
				+ srow.contactNumber + '</span></td>';
		contents = contents + '      </tr>';
		contents = contents + '    <tr>';
		contents = contents
				+ '            <td>Loan Amount   :  <span id="loanAmount" style="margin-left: 20px;font-size: 15;font-weight: normal;">'
				+ srow.loanAmount + '</span></td>';
		contents = contents + '      </tr>';
		contents = contents + '         <tr>';
		contents = contents
				+ '            <td>SSN   :  <span id="ssn" style="margin-left: 20px;font-size: 15;font-weight: normal;">'
				+ srow.ssn + '</span></td>';
		contents = contents + '      </tr>';
		contents = contents + '  </tbody>';
		contents = contents + '<td><div class="form-group">';
		contents = contents + '<form name="pendingList">';
		contents = contents
				+ '<button type="button" class="btn btn-primary" onclick = "hidePending('
				+ srow.id
				+ ')" style="display: inline;margin-left: 30px;" id="accept">Accept</button>';
		contents = contents
				+ '<button type="button" class="btn btn-primary" onclick = "deleteRecord('
				+ srow.id
				+ ')" style="display: inline;margin-left: 40px;" id="reject">Reject</button>';
		contents = contents + '</form>';
		contents = contents + '</div>';
		contents = contents + '</td>';
		contents = contents + '</table>';
		contents = contents + '<hr/>';
		contents = contents + '</div>';
	}
</script>
<style>
body {
	background-color: #ffffff;
}
</style>

</head>
<body>
	<img alt="" src="${pageContext.request.contextPath}/img/smile.gif"
		height="120px;"
		style="width: 100px; display: inline; margin-left: 40px;">
	<h2 style="color: #4000ff; display: inline; margin-left: 40px;">Pending
		list ...</h2>
	<hr style="border-width: 10px;" />
	<div style="margin-left: 30px;">
		<div class="form-group">
			<form name="pendingList">
				<button type="button" class="btn btn-primary" id="search">Show
					list</button>
			</form>
		</div>
		<br />
		<h4 style="color: red;">status: Pending/Accept/Reject</h4>
		<br />

		<div id="searchResult"></div>
	</div>
</body>
</html>