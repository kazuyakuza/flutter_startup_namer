import 'package:flutter/material.dart';
import 'package:tutorial_startup_namer/model/start-up-idea.model.dart';
import 'package:tutorial_startup_namer/service/idea-storage.service.dart';

const APP_TITLE = 'Startup Idea Generator';

const BIGGER_FONT = TextStyle(fontSize: 18.0);

final STORAGE = IdeaStorageService();
Set<StartUpIdea> STORAGE_CACHE;
