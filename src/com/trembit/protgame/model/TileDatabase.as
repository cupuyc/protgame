package com.trembit.protgame.model
{
	import com.custardbelly.as3couchdb.core.CouchDatabase;
	import com.custardbelly.as3couchdb.core.CouchModelEntity;
	import com.custardbelly.as3couchdb.mediator.CouchDatabaseActionMediator;
	import com.custardbelly.as3couchdb.service.HTTPCouchRequest;
	import com.trembit.protgame.util.Endpoint;

	public class TileDatabase extends CouchDatabase
	{
		public function TileDatabase( entity:CouchModelEntity = null)
		{
			var mediator:CouchDatabaseActionMediator=new CouchDatabaseActionMediator();
			var request:HTTPCouchRequest=new HTTPCouchRequest();
			var entity:CouchModelEntity=new CouchModelEntity(Endpoint.COUCHDB, "tiles", request, mediator);
			super(entity);
		}
	}
}