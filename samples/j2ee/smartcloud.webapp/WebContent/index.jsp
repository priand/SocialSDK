<%@page import="com.ibm.sbt.smartcloud.Util"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<title>Smart Cloud Sample</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript" src="/sbt.dojo180/dojo/dojo.js" djConfig="parseOnLoad: true"></script>
<script type="text/javascript" src="/smartcloud.webapp/library?lib=dojo&ver=1.8.0"></script>

<%
%>

<link rel="stylesheet" href="<%=Util.getThemeUrl()%>" type="text/css" />
</head>

<body class="lotusui30_body">
<div class="lotusui30 lotusui30_fonts scloud3">
	<script type="text/javascript" src="<%=Util.getNavBarUrl()%>"></script>
</div>

<div>
	<div style="float:left;border:10px solid white;">
		<div>
			<img width="128" height="128" src="" id="photo">
		</div>
	</div>
	<div style="border:20px solid white;">
		<div>
			<strong id="name"></strong>
		</div>
		<div>
			<div id="jobTitle"></div>
			<div id="department"></div>
			<div id="address"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
require([ "sbt/smartcloud/ProfileService", "sbt/dom", "sbt/Endpoint" ], function(ProfileService, dom, Endpoint) {

	var endpoint = Endpoint.find("smartcloud");
	var url = "/manage/oauth/getUserIdentity";
	var options = { handleAs : "json" };
	endpoint.request(url, options).then(
		function(response) {
			handleUserIdentity(response);
	});

	function handleUserIdentity(entry) {
		var profileId = entry.subscriberid;
		var profileDisplayName = entry.name;
		var profileService = new ProfileService();
		profileService.getProfileByGUID(profileId).then(function(profile) {
			dom.setText("name", profile.getDisplayName());
			dom.byId("photo").src = profile.getThumbnailUrl();
			dom.setText("jobTitle", profile.getTitle());
			dom.setText("address", profile.getAddress());
			dom.setText("department", profile.getDepartment());
		});
	}
});
</script>

</body>

</html>