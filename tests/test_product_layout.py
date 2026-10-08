from pathlib import Path


def test_nested_initiative_story_task_layout_is_used():
    project_root = Path(__file__).resolve().parents[1]

    assert (project_root / ".sandstraw" / "state.json").exists()
    assert (project_root / ".sandstraw" / "project-memory.md").exists()
    assert (project_root / ".sandstraw" / "product" / "initiatives").is_dir()

    assert not (project_root / ".sandstraw" / "product" / "stories").exists()
    assert not (project_root / ".sandstraw" / "product" / "tasks").exists()

    example_task = project_root / ".sandstraw" / "product" / "initiatives" / "001-example-initiative" / "001-example-story" / "001-example-task" / "task.md"
    assert example_task.exists(), "Nested initiative-story-task example should exist in the docs-backed structure."
