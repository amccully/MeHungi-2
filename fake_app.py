from flask import Flask
from flask_restful import Api, Resource, reqparse, abort

application = Flask(__name__)
api = Api(application)

class Endpoint(Resource):
    def get(self):
        return {} 
    def post(self):
        return {}
    def put(self):
        return {}
    def delete(self):
        return "",200

myParser = reqparse.RequestParser()

myParser.add_argument("someInt", type=int, help="Put in the number")

api.add_resource(Endpoint, "/endpoint")

if __name__ == "__main__":
    application.run(debug=True)

