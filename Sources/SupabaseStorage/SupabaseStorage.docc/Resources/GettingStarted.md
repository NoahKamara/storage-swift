#  GettingStarted

This is a quick guide that shows the basic functionality of Supabase Storage.


## Create a bucket

You can create a bucket using ``StorageBucketApi/createBucket(id:isPublic:)``.

Here we create a bucket called "avatars":

```swift
var bucketID = StorageBucketApi.createBucket(id: "avatars")
```



## Upload a file

You can upload a file using ``StorageFileApi/upload(path:file:fileOptions:)``.

```swift
let helloWorldFile = File(
    name: "HelloWorld.md",
    data: data,
    fileName: "HelloWorld.md",
    contentType: "text/markdown"
)

try await storage
    .from(id: "greetings")
    .upload(path: "public/HelloWorld.md", helloWorldFile)
```


## Public and Private Buckets

Storage buckets are private by default.

#### Private Buckets
For private buckets, you can access objects via the ``StorageFileApi/download(path:)`` method. This corresponds to /object/auth/ API endpoint. 

Alternatively, you can create a **publicly shareable** URL with an expiry date using the ``StorageFileApi/createSignedURL(path:expiresIn:)`` method which calls the /object/sign/ API.


#### Public Buckets
For public buckets, you can access the assets directly without a token or an Authorisation header. The ``StorageFileApi/getPublic`` helper method returns the full public URL for an asset. This calls the /object/public/ API endpoint internally. While no authorization is required for accessing objects in a public bucket, proper access control is required for other operations like uploading, deleting objects from public buckets as well.

Public buckets also tend to have better performance.
