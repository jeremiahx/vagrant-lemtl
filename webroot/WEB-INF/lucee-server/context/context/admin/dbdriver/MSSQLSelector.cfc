<!--- 
 *
 * Copyright (c) 2014, the Railo Company Ltd. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 ---><cfcomponent implements="types.IDriverSelector">

	
	<cffunction name="getName" returntype="string"  output="no"
		hint="returns display name of the driver">

		<cfreturn "MSSQL Database Driver (selector)">
	</cffunction>

	
	<cffunction name="getDescription" returntype="string"  output="no"
		hint="returns description for the driver">

		<cfreturn "This selector allows to choose from different types of MSSQL database drivers">
	</cffunction>
	

	<cffunction name="getOptions" returntype="array" output="false" hint="returns an array of drivers to choose from. the first item in the array is selected by default.">
	
		<cfset var result = [ "MSSQL2", "MSSQL" ]>
		
		<cfreturn result>
	</cffunction>

	
</cfcomponent>