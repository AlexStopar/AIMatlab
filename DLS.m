function [ result ] = DLS( InitialState, limit, GoalState)
    %DLS Summary of this function goes here
    %   Detailed explanation goes here
    node = struct('state', InitialState, 'pathcost', 0, 'parent', GoalState);
    result = RecursiveDFS(node, limit, GoalState);
end

