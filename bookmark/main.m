//
//  main.m
//  bookmark
//
//  Created by Brett Terpstra on 7/5/14.
//  Copyright (c) 2014 Brett Terpstra. All rights reserved.
//
//  Stupid little CLI tool to return a base64 string of encoded bookmark data
// for a file
//  or retrieve a file when given a base64 string.

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]) {
  if (argc != 3) {
    fprintf(stderr, "Invalid number of argument\n");
    fprintf(stderr, "Get bookmark for file: %s save filename\n"
                    "Find file with bookmark: %s find (bookmark data)\n",
            argv[0], argv[0]);
    return 1;
  }
  @autoreleasepool {

    NSString *type =
        [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];

    if ([type isEqual:@"save"] || [type isEqual:@"s"]) {
      NSString *filename =
          [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
      NSFileManager *fm = [NSFileManager defaultManager];
      BOOL isDir;

      if ([fm fileExistsAtPath:[filename stringByExpandingTildeInPath]
                   isDirectory:&isDir]) {
        NSURL *fileurl =
            [NSURL fileURLWithPath:[filename stringByExpandingTildeInPath]];
        NSData *bookmark = [fileurl
                   bookmarkDataWithOptions:NSURLBookmarkCreationMinimalBookmark
            includingResourceValuesForKeys:NULL
                             relativeToURL:NULL
                                     error:NULL];

        printf("%s",
               [[bookmark
                   base64EncodedStringWithOptions:
                       NSDataBase64EncodingEndLineWithLineFeed] UTF8String]);

      } else {
        fprintf(stderr, "File not found\n");
        return 1;
      }

    } else if ([type isEqual:@"find"] || [type isEqual:@"f"]) {
      NSString *stringData =
          [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
      NSData *data = [[NSData alloc]
          initWithBase64EncodedString:stringData
                              options:
                                  NSDataBase64DecodingIgnoreUnknownCharacters];
      NSError *err;
      BOOL isStale;
      NSURL *target =
          [NSURL URLByResolvingBookmarkData:data
                                    options:NSURLBookmarkResolutionWithoutUI
                              relativeToURL:NULL
                        bookmarkDataIsStale:&isStale
                                      error:&err];

      if (!err) {
        printf("%s", [[target path] UTF8String]);

      } else {
        return 1;
      }
    } else {
      fprintf(stderr, "Invalid argument\n");
      fprintf(stderr, "Get bookmark for file: bookmark save filename\nFind "
                      "file with bookmark: bookmark find (bookmark data)\n");
      return 1;
    }
  }
  return 0;
}
