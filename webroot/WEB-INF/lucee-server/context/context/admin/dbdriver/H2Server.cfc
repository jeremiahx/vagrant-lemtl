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
 ---><cfcomponent extends="types.Driver" implements="types.IDatasource">

	<cfset fields = array(
	
		  field( "Path", "path", "" , true, "Path where the database is or should be located (only Filesystem, virtual Resources like ""ram"" not supported)" )
		
		, field( "Mode", "mode", "MySQL,DB2,Derby,HSQLDB,MSSQLServer,Oracle,PostgreSQL", true, "All database engines behave a little bit different. For certain features, this database can emulate the behavior of specific databases. Not all features or differences of those databases are implemented.", "radio" )
		
		, field( "Ignore Case", "ignoreCase", "TRUE,FALSE", true, "Whether String Comparison should be case sensitive (false) or not (true)", "radio" )
	)>
	
	<cfset this.type.host 		= this.TYPE_REQUIRED>
	
	<cfset this.value.host		= "localhost">
	<cfset this.value.username	= "sa">
	
	<cfset this.dsn				= "jdbc:h2:tcp://{host}/{path}{database};MODE={mode};IGNORECASE={ignoreCase}">
	
	<cfset this.className 		= "org.h2.Driver">

	<cfset SLASH=struct(
		'/':'\',
		'\':'/'
	)>
	
	
	<cffunction name="onBeforeUpdate" returntype="void" output="no">
	
		<cfset form.custom_path = replace( form.custom_path, SLASH[ server.separator.file ], server.separator.file, 'all' )>
		
		<cfif right( form.custom_path, 1 ) NEQ server.separator.file>
		
			<cfset form.custom_path= form.custom_path & server.separator.file>
		</cfif>
		
		<cfif !directoryExists( form.custom_path )>
		
			<cfset var parent = mid( form.custom_path, 1, len( form.custom_path ) - 1 )>
			<cfset parent = getDirectoryFromPath( parent )>
			
			<cfif directoryExists( parent )>
			
				<cfdirectory directory="#form.custom_path#" action="create" mode="777">
			<cfelse>
			
				<cfthrow message="directory [#form.custom_path#] doesn't exist">
			</cfif>
		</cfif>
	</cffunction>
	
	
	<cffunction name="getName" returntype="string"	output="no" hint="returns display name of the driver">
	
		<cfreturn "H2 Database Engine in Server Mode">
	</cffunction>
	
	
	<cffunction name="getDescription" returntype="string"  output="no" hint="returns description for the driver">
	
		<cfreturn "Create a connection to an existing H2 Database or create a new H2 Database.
		In order to create a new database, specify a path/database-name that does not exist with username ""sa"" and password """" (empty string).  H2 must be running in Server Mode.">
	</cffunction>
	
	
	<cffunction name="getFields" returntype="array"  output="no"	hint="returns array of fields">
	
		<cfreturn fields>
	</cffunction>
	
	
</cfcomponent>